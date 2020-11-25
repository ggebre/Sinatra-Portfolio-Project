class AppointmentsController < ApplicationController 


    get '/appointments/patient/:id' do 
        appointments = Patient.find(params[:id]).appointments 
        @appointments = appointments.select{|appointment| appointment.staff_id == current_user.staff_id}
        erb :'/appointments/show'
    end

    # NEW APPOINTMENT FOR A PATIENT 
    get '/appointments/:id/new' do 
        @staffs = Staff.all
        @patient = Patient.find(params[:id])
        
        erb :'/appointments/new'
    end

    post '/appointments/:id' do 

        if params[:appointment][:date].empty? || !params[:staff] 
            flash[:error] = "Practitioner and date should be chosen or entered!"
            redirect "/appointments/#{params[:id]}/new"
        else
            appointment = Appointment.create(appointment_date: params[:appointment][:date])
            
            appointment.staff_id = params[:staff][:id]
            appointment.patient_id = params[:id]
            appointment.save 
            
            if current_user.patient_id == params[:id].to_i 
                redirect "/patients/#{params[:id]}"
            else 
                flash[:message] = "Successfully created appointment"
                redirect '/staffs'
            end
        end
    end

    # NEW DIAGNOSIS DETAIL FOR A PATIENT 

    get '/appointments/:id/diagnosis' do 
        
        @patient = Patient.find(params[:id])
        erb :'/appointments/show_diagnosis'
    end

   

end