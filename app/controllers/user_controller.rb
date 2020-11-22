class UserController < ApplicationController 
    
    get '/signup' do 
        
        erb :'/users/signup'
    end

    post '/signup' do 

        # check if the patient is in the database by referencing with DOB and full Name 
        patient = Patient.find_by(dob: params[:user][:dob], name: params[:user][:name])
        staff = Staff.find_by(dob: params[:user][:dob], name: params[:user][:name])
        
        if patient || staff 
            user = User.create(params[:user])

            patient.user = user if patient 
            staff.user = user if staff 
            
            session[:user_id] = user.id
            
            if patient 
                redirect "/patients/#{patient.slug}"
            else
                
                redirect "/staffs"
            end
        else 
            # YOU ARE NOT IN OUR SYSTEM 
            flash[:message] = "YOUR ARE NOT IN OUR SYSTEM"
            redirect '/signup'
        end
    end

    get '/login' do 
        erb :'/users/login'
    end
    post '/login' do 
        # checks if the user is a patient or staff to render relevant informations 
       
        user = User.find_by(name: params[:user][:name])


        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            # if user patient, do something if now, staff 
           if user.patient_id 
            # redirect to patient detail...appointments, prescriptions,....
                patient = Patient.where(user: user).first
                redirect "/patients/#{patient.slug}"
           else 
                redirect '/staffs'
           end
        else 
            flash[:message] = "Incorrect username or password " 
            redirect "/login"
        end
    end

    get '/logout' do 
        session.clear 
        flash[:message] = "You successfully log out"
        redirect '/'
    end


end