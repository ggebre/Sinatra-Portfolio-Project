class CommentsController < ApplicationController 

    get '/comments/:staff_id' do 
        staff= Staff.find(params[:staff_id])
        @comments = staff.comments 

        erb :'/comments/show'
    end

    post '/comments' do 
        
        comment = Comment.create(params[:comment])
        comment.staff_id = params[:staff][:id]
        comment.patient_id = current_user.patient_id

        comment.save 
        
        redirect "staffs/doctors/#{params[:staff][:id]}"
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
        
        flash[:message] = "Successfully updated a comment!!"
        redirect "/staffs/doctors/#{comment.staff_id}"
    end

    delete '/comment/:id' do 
        comment = Comment.find(params[:id])
        # staff = Staff.find(comment.staff_id)
       
        staff = comment.staff 
        if logged_in? && comment.patient.user.id == session[:user_id]
            comment.destroy
        end
        flash[:message] = "Successfully deleted a comment!!"
        redirect "/staffs/doctors/#{comment.staff_id}"
    end
end