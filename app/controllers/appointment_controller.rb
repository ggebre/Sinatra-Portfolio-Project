class AppointmentsController < ApplicationController 

    
    get '/appointments/old_appointments' do 
        
        # find the patient and filter out his/her appointments as old and upcoming
        # render it on /appointments/show_appointments page  
        
       
        @appointments = Appointment.appointments_for_a_patient_with(current_user.patient_id).select {|appointment| appointment.is_upcoming?} 
       
        erb :'/appointments/show_appointments'
    end

    get '/appointments/upcoming_appointments' do 
    
        # find the patient and filter out his/her appointments as old and upcoming
        # render it on /appointments/show_appointments page  
        
        @appointments = Appointment.appointments_for_a_patient_with(current_user.patient_id).select {|appointment| !appointment.is_upcoming?} 
       
        erb :'/appointments/show_appointments'
    end


    get '/appointments/:id' do 
        @appointment = Appointment.find(params[:id])
        erb :'/appointments/show'
    end

    # NEW APPOINTMENT FOR A PATIENT 
    get '/appointments/:slug/new' do 
        @staffs = Staff.all
        @patient = Patient.find_by_slug(params[:slug])
        
        erb :'/appointments/new'
    end

    post '/appointments/:slug' do 

        appointment = Appointment.create(appointment_date: params[:appointment][:date])
        

        appointment.staff_id = params[:staff][:id].to_i
        appointment.patient_id = params[:patient][:id].to_i
        appointment.save 
        
        if current_user.patient_id == params[:patient][:id].to_i

            redirect "/patients/#{params[:slug]}/appointments"
        else 
            flash[:message] = "Successfully created appointment"
            redirect '/staffs'
        end
    end

    # NEW DIAGNOSIS DETAIL FOR A PATIENT 

    get '/appointments/:slug/diagnosis' do 
        
        @patient = Patient.find_by_slug(params[:slug])
        erb :'/appointments/show_diagnosis'
    end

   

end