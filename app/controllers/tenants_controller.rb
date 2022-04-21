class TenantsController < ApplicationController
    def index
        tenants = Tenant.all 
        render json: tenants, status: :ok  
    end 

    def show 
        tenant = Tenant.find_by(id: params[:id])
        render json: tenant, status: :ok  
    end 

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created 
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def update
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.update!(tenant_params)
            render json: tenant, status: :ok
        else 
            render json: {error: "not found"}
        end 
        rescue ActiveRecord::RecordInvalid => invalid 
            render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 
    end 

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.destroy
            render json: {}
        else 
            render json: {error: "not found"}
        end 
    end 

    private

    def tenant_params
        params.permit(:name, :age)
    end 

end
