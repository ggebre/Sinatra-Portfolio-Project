class AppointmentsController < ApplicationController 

    get '/appointments' do 
        # erb :"/appointments/index"
    end
    get '/appointments/old_appointments' do 
        
        # find the patient and filter out his/her appointments as old and upcoming
        # render it on /appointments/show_appointments page  
        @patient = Patient.find_patient(session[:user_id]) 
        @appointments = @patient.appointments.order(appointment_date: :desc).select {|appointment| appointment.is_upcoming?} 
        erb :'/appointments/show_appointments'
    end

    get '/appointments/upcoming_appointments' do 
    
        # find the patient and filter out his/her appointments as old and upcoming
        # render it on /appointments/show_appointments page  
        @patient = Patient.find_patient(session[:user_id]) 
        @appointments = @patient.appointments.order(appointment_date: :desc).select {|appointment| !appointment.is_upcoming?} 
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

        
        patient = Patient.find_by_slug(params[:slug])
        doctor = Staff.find(params[:staff][:id])
       
        
        @appointment = Appointment.create(appointment_date: params[:appointment][:date])
        
        patient.appointments << @appointment
        doctor.appointments << @appointment
        
        # if staff created appointment redirect to 
        
        if User.find(session[:user_id]) == patient.user  

            redirect "/patients/#{patient.slug}/appointments"
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