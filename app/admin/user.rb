ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :email,:password, :first_name, :last_name, :gender, :phone, :age, :address, :postcode,:id, :buyer_band, :seller_band, :paypal_email
#


index do 
  id_column
    column :email
    column :buyer_band
    column :seller_band
    column :first_name
    column :last_name
    column :gender
    column :phone
    column :age
    actions
end
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
