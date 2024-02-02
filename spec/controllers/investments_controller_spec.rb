require 'rails_helper'

RSpec.describe InvestmentsController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do

    let(:valid_params) { { investment: { cryptocurrency_id: FactoryBot.create(:cryptocurrency).id, amount: 100 } } }
    subject { post :create, params: valid_params }
    
    it 'creates a new investment' do
      expect { subject }.to change(Investment, :count).by(1)
    end

    context 'with valid parameters' do

      it 'redirects to new_investiment' do
        post :create, params: { investment: { cryptocurrency_id: 52, amount: 300 } }
          expect(response).to redirect_to(new_investment_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new investment' do
        expect {
          post :create, params: { investment: { cryptocurrency_id: nil, amount: 100 } }
        }.not_to change(Investment, :count)
      end

      it 'redirects to new_investment' do
        post :create, params: { investment: { cryptocurrency_id: nil, amount: 100 } }
        expect(response).to redirect_to(new_investment_path)
      end
    end
  end

  describe 'GET #export_json' do
    it 'returns a successful response' do
      get :export_json, format: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #export_csv' do
    it 'returns a successful response' do
      get :export_csv, format: :csv
      expect(response).to be_successful
    end
  end
end
