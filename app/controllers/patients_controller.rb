class PatientsController < ApplicationController 
    
    get '/patients/:slug/edit' do 
        @patient = Patient.find_by_slug(params[:slug])
        erb :'/patients/edit'
    end

    patch '/patients/:slug' do 
        patient = Patient.find_by_slug(params[:slug])
        

        email = params[:patient][:email]
        phone = params[:patient][:phone]
        address = params[:patient][:address]
        if !email.empty?
            patient.update(email: email)
        end
        if !phone.empty?
            patient.update(phone: phone)
        end
        if !address.empty?
            patient.update(address: address)
        end
        
        flash[:message] = "#{patient.name}'s data is updated successfully! "
        redirect "/appointments/#{patient.slug}/new"

    end
    get '/patients/new' do 
        erb :'/patients/registration'
    end

    post '/patients' do 
        
        patient = Patient.find_by(name: params[:patient][:name], dob: params[:patient][:dob])
        if !patient
            patient = Patient.create(params[:patient])
            flash[:message] = "You successfully added #{patient.name}!!"
        end
        redirect "/appointments/#{patient.slug}/new"
        
    end

    get '/patients/search' do 
        # search for a patient with name and dob
        erb :'/patients/search'
    end

    post '/patients/search' do 
        
        patient = Patient.find_by(name: params[:patient][:name], dob: params[:patient][:dob])
        
        if patient 
        # once this is set, then set appointment or view appointments 
        # redirect to staff's page 
            redirect "/patients/#{patient.slug}"
        else
            # error message PATIENT NOT FOUND
            flash[:message] = "Incorrect Name or DOB entered"
            redirect '/patients/search'
        end
    end

    # when patient logs in, it lands on this page
    get '/patients/:slug' do 

        
        @patient = Patient.find_by_slug(params[:slug])

        @staff = Staff.find_staff(session[:user_id])
        # if patient is accessing info or staff accessing info 
            # erb :'/patients/show'
        @prescriptions = Prescription.all 

        if @patient.user && session[:user_id] == @patient.user.id
            erb :'/patients/appointment_list'
        else
            if @staff.is_doctor?
                erb :'/appointments/show_diagnosis'
            else
                # appointment set up page 
               
                redirect "/appointments/#{@patient.slug}/new"
                # erb :'/patients/appointment_list'
            end
        end
        
    end

    post '/patients/diagnosis/:slug' do 
        # find patient 
        # get patient.appointment where appointment date 

        # appointments_for_a_patient_with(patient_id)
        patient = Patient.find_by_slug(params[:slug])
        todays_appointment = patient.todays_appointment
        
       
        # find the appointment with today's date
        # update the diagnosis_note 
        todays_appointment.update(diagnosis_note: params[:appointment][:diagnosis])
        todays_appointment.prescriptions << Prescription.find(params[:prescription])
        redirect "/staffs"
    end
    

    get '/patients/:slug/appointments' do  
        @patient = Patient.find_by_slug(params[:slug])
        erb :'/patients/appointment_list'
    end
    
    get '/patients/:slug/prescription' do 
        @patient = Patient.find_by_slug(params[:slug])
        # redirect to prescription show page 
    end

    get '/patients/:slug/diagnosis' do 
        @patient = Patient.find_by_slug(params[:slug])
        # redirect to diagnosis 
    end

end