class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[ edit update destroy]

  def index
    @apartments = Apartment.all
    mismatched = Apartment.where(fragmented: true).select(&:area_mismatch?)
    if mismatched.present?
      numbers = mismatched.map { |a| a.number }.join(", ")
      flash.now[:alert] = "Следующие квартиры имеют несоответствие заявленой площади и дробей: #{numbers}"
    end
  end

  def new
    @apartment = Apartment.new
  end

  def edit; end

  def create
    @apartment = Apartment.new(apartment_params)

    if @apartment.save
      redirect_to apartments_path, notice: "Apartment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to apartments_path, notice: "Apartment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @apartment.destroy!

    redirect_to apartments_path, notice: "Apartment was successfully destroyed.", status: :see_other
  end

  private

  def set_apartment
    @apartment = Apartment.find(params.expect(:id))
  end

  def apartment_params
    params.expect(apartment: %i[number prefix name fragmented area parent_apartment_id])
  end
end
