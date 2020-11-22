class Comment < ActiveRecord::Base
    belongs_to :patient
    belongs_to :staff

    
end