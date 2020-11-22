class StaffsController < ApplicationController 
    get '/staffs' do 
        
        erb :'/staffs/index'
    end
    
    get '/staffs/:slug/comments' do 
        @staff = Staff.find_by_slug(params[:slug])
        erb :'/comments/show'
    end


    get '/staffs/doctors' do 
        @doctors = Staff.doctors_list 
        erb :'/staffs/doctors_list'
    end

    get '/staffs/doctors/:slug' do 
        @doctor = Staff.find_by_slug(params[:slug])
        
        erb :'/staffs/doctor_detail'
    end
    get '/staffs/:slug' do 
        @staff = Staff.find_by_slug(params[:slug])
        erb :'/staffs/show'
    end



end