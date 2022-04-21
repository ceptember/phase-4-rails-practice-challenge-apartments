class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all 
        render json: apartments
    end

    def show
        apartment = Apartment.find_by(id: params[:id])
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created  
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def update
        apartment = Apartment.find_by(id: params[:id])
        if apartment 
            apartment.update!(apartment_params)
            render json: apartment, status: :ok 
        else 
            render json: {error: "not found"}

        end 

     rescue ActiveRecord::RecordInvalid => invalid 
            render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity

    end 

    def destroy
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            apartment.destroy
            render json: {}
        else 
            render json: {error: "not found"}
        end 
    end 


    private 

    def apartment_params
        params.permit(:number)
    end 
end
