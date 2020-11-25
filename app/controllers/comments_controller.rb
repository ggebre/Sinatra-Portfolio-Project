class CommentsController < ApplicationController 

    post '/comments' do 
        
        
        staff = Staff.find(params[:staff][:id]) 
        comment = Comment.create(params[:comment])
        
        
        comment.staff_id = params[:staff][:id]
        comment.patient_id = current_user.patient_id
        comment.save 
        
        

        redirect "staffs/doctors/#{staff.slug}"
    end

    get '/comments/:id/edit' do 
        @comment = Comment.find(params[:id])
        erb :'/comments/edit'
    end

    patch '/comment/:id' do 
        comment = Comment.find(params[:id])
        
        if logged_in? && comment.patient.user.id == session[:user_id]
            comment.update(content: params[:comment][:content])
        end
        staff = Staff.find(comment.staff_id)
        flash[:message] = "Successfully updated a comment!!"
        redirect "/staffs/doctors/#{staff.slug}"
    end

    delete '/comment/:id' do 
        comment = Comment.find(params[:id])
        # staff = Staff.find(comment.staff_id)
        staff = comment.staff 
        if logged_in? && comment.patient.user.id == session[:user_id]
            comment.destroy
        end
        flash[:message] = "Successfully deleted a comment!!"
        redirect "/staffs/doctors/#{staff.slug}"
    end
end