class PatientsController < ApplicationController 
    
   
    # when patient logs in, it lands on this page
    get '/patients/:id' do 
       
        @patient = Patient.find(params[:id])

        erb :'/patients/index'
        
    end

    post '/patients/appointment/:id' do 
        # find appointment 
        appointment = Appointment.find(params[:id])
        
        # update the diagnosis_note 
        appointment.update(diagnosis_note: params[:appointment][:diagnosis])
        appointment.prescriptions << Prescription.find(params[:prescription])
        redirect "/appointments/patient/#{appointment.patient_id}"
    end
    
# APPOINTMENT LIST 
    get '/patients/:id/upcoming_appointments' do  
        patient = Patient.find(params[:id])
        @appointments = patient.appointments.select{|appointment| appointment.appointment_date >= Time.now}
        erb :'/appointments/show'
        # erb :'/patients/appointment_list'
    end

    get '/patients/:id/old_appointments' do  
        patient = Patient.find(params[:id])
        @appointments = patient.appointments.select{|appointment| appointment.appointment_date < Time.now}
        erb :'/appointments/show'
        # erb :'/patients/appointment_list'
    end

    get '/patients/:id/prescription' do 
        @patient = Patient.find(params[:id])
        
        # redirect to prescription show page 
    end

    get '/patients/:id/appointment/:appointment_id' do 
        @patient = Patient.find(params[:id])
        @appointment = Appointment.find(params[:appointment_id])
        @prescriptions = Prescription.all
        # redirect to diagnosis 
        if current_user.staff_id
            erb :'/appointments/show_diagnosis'
        else
            # details of the given link 
            erb :'/appointments/show_appointment'
        end
    end

end