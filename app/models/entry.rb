class Entry < ActiveRecord::Base
    
###### Active Record Assosciations ######
    belongs_to :user
    belongs_to :parent_entry, class_name: "Entry"
    has_many   :child_entries, class_name: "Entry", foreign_key: "parent_entry_id"
    
###### Validations ######
    validates :title, 
        presence: true, 
        length: { maximum: 255 }
    
    validates :content, 
        presence: true
    
end