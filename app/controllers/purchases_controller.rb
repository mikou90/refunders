class PurchasesController < ApplicationController
  before_action :find_purchase, only: [:show, :destroy, :index ]


  def index
    @purchases = current_user.purchases
  end

  def show
    @purchase = current_user.purchases.find(params[:id])
  end

  def new
    @purchase = current_user.purchases.new
  end

  def create
    @purchase = current_user.purchases.new(purchase_params)
    @purchase.announce_sku = @purchase.announce.sku
    @purchase.state = "pending"

    if @purchase.save
      redirect_to new_purchase_payment_path(@purchase[:id])
    else
      render :back
    end
  end

  def destroy
    @purchase.destroy
    redirect_to root_path, notice: "La vente a été annulée"
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :announce_id)
  end

  def find_purchase
    @purchase = current_user.purchases.find(params[:id])
  end
end
