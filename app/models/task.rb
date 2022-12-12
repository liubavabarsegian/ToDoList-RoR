class Task < ApplicationRecord
    validates :title, presence: true

    #actually it returns due date, but i need this variable to be 
    #name as start_time cuz i want to use task model as event
    def start_time 
        self.due
    end
end
