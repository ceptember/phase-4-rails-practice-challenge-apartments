class LeasesController < ApplicationController

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created 
    end 

    def destroy
        lease = Lease.find_by(id: params[:id])
        if lease 
            lease.destroy
            render json: {}
        else 
            render json: {error: "not found"}
        end 
        
    end 

    private

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end 
end
