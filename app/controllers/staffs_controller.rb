class StaffsController < ApplicationController 
    get '/staffs' do 
        erb :'/staffs/index'
    end
    
    get '/staffs/:id/comments' do 
        # @staff = Staff.find_by_slug(params[:slug])
        @staff = Staff.find(params[:id])
        @comments = Comment.comments_to_a_staff_with(@staff.id)
        erb :'/comments/show'
    end


    get '/staffs/doctors' do 
        @doctors = Staff.all_practitioners 
        erb :'/staffs/doctors_list'
    end

    get '/staffs/doctors/:id' do 
        @doctor = Staff.find(params[:id])
        erb :'/staffs/doctor_detail'
    end


    
    # NEW PATIENT REGISTRATION AND EDIT BY STAFF 

    get '/staffs/patients/:id/edit' do 
        @patient = Patient.find(params[:id])
        erb :'/patients/edit'
    end

    patch '/staffs/patients/:id' do 
        patient = Patient.find(params[:id])
        

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
        redirect "/appointments/#{patient.id}/new"

    end

    get '/staffs/patients/new' do 
        erb :'/patients/registration'
    end

    post '/staffs/patients' do 
        
        patient = Patient.find_by(name: params[:patient][:name], dob: params[:patient][:dob])
        if !patient
            patient = Patient.create(params[:patient])
            flash[:message] = "You successfully added #{patient.name}!!"
        end
        redirect "/appointments/#{patient.id}/new"
        
    end

    get '/staffs/patients/search' do 
        # search for a patient with name and dob
        erb :'/patients/search'
    end

    post '/staffs/patients/search' do 
        
        patient = Patient.find_by(name: params[:patient][:name], dob: params[:patient][:dob])
        
        if patient 
        # once this is set, then set appointment or view appointments 
        # redirect to staff's page 
            redirect "/patients/#{patient.id}"
        else
            # error message PATIENT NOT FOUND
            flash[:message] = "Incorrect Name or DOB entered"
            redirect '/patients/search'
        end
    end



end