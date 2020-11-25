class AppointmentsController < ApplicationController 


    get '/appointments/:id' do 
        @appointment = Appointment.find(params[:id])
        erb :'/appointments/show'
    end

    # NEW APPOINTMENT FOR A PATIENT 
    get '/appointments/:id/new' do 
        @staffs = Staff.all
        @patient = Patient.find(params[:id])
        
        erb :'/appointments/new'
    end

    post '/appointments/:id' do 

        appointment = Appointment.create(appointment_date: params[:appointment][:date])
        

        appointment.staff_id = params[:staff][:id].to_i
        appointment.patient_id = params[:patient][:id].to_i
        appointment.save 
        
        # if current_user.patient_id == params[:patient][:id].to_i
            
            redirect "/patients/#{params[:id]}"
        # else 
        #     flash[:message] = "Successfully created appointment"
        #     redirect '/staffs'
        # end
    end

    # NEW DIAGNOSIS DETAIL FOR A PATIENT 

    get '/appointments/:id/diagnosis' do 
        
        @patient = Patient.find(params[:id])
        erb :'/appointments/show_diagnosis'
    end

   

end