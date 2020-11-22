class CommentsController < ApplicationController 

    post '/comments' do 
        
        user = User.find(session[:user_id])
        patient = Patient.find(user.patient_id)
        staff = Staff.find(params[:staff][:id]) 
        comment = Comment.create(params[:comment])
        patient.comments << comment 
        staff.comments << comment 

        redirect "staffs/doctors/#{staff.slug}"
    end

    get '/comments/:id/edit' do 
        @comment = Comment.find(params[:id])
        erb :'/comments/edit'
    end

    patch '/comment/:id' do 
        comment = Comment.find(params[:id])
        comment.update(content: params[:comment][:content])
        staff = Staff.find(comment.staff_id)
        flash[:message] = "Successfully updated a comment!!"
        redirect "/staffs/doctors/#{staff.slug}"
    end

    delete '/comment/:id' do 
        comment = Comment.find(params[:id])
        staff = Staff.find(comment.staff_id)
        comment.destroy
        flash[:message] = "Successfully deleted a comment!!"
        redirect "/staffs/doctors/#{staff.slug}"
    end
end