class PatientsController < ApplicationController 
    

    # when patient logs in, it lands on this page
    get '/patients/:id' do 

        @patient = Patient.find(params[:id])

        erb :'/patients/appointment_list'

        # @staff = Staff.find_staff(session[:user_id])
        # # if patient is accessing info or staff accessing info 
        #     # erb :'/patients/show'
        # @prescriptions = Prescription.all 

        # if @patient.user && session[:user_id] == @patient.user.id
        #     erb :'/patients/appointment_list'
        # else
        #     if @staff.is_doctor?
        #         erb :'/appointments/show_diagnosis'
        #     else
        #         # appointment set up page 
               
        #         redirect "/appointments/#{@patient.id}/new"
        #         # erb :'/patients/appointment_list'
        #     end
        # end
        
    end

    post '/patients/:id/diagnosis' do 
        # find patient 
        # get patient.appointment where appointment date 

        # appointments_for_a_patient_with(patient_id)
        patient = Patient.find(params[:id])
        todays_appointment = patient.todays_appointment
        
       
        # find the appointment with today's date
        # update the diagnosis_note 
        todays_appointment.update(diagnosis_note: params[:appointment][:diagnosis])
        todays_appointment.prescriptions << Prescription.find(params[:prescription])
        redirect "/staffs"
    end
    
# APPOINTMENT LIST 
    get '/patients/:id/upcoming_appointments' do  
        patient = Patient.find(params[:id])
        @appointments = patient.appointments.select{|appointment| !appointment.is_upcoming?}
        erb :'/appointments/show'
        # erb :'/patients/appointment_list'
    end

    get '/patients/:id/old_appointments' do  
        patient = Patient.find(params[:id])
        @appointments = patient.appointments.select{|appointment| appointment.is_upcoming?}
        erb :'/appointments/show'
        # erb :'/patients/appointment_list'
    end





    get '/patients/:id/prescription' do 
        @patient = Patient.find(params[:id])
        # redirect to prescription show page 
    end

    get '/patients/:id/diagnosis' do 
        @patient = Patient.find(params[:id])
        # redirect to diagnosis 
    end

end