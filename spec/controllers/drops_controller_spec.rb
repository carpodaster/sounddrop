require 'spec_helper'
require 'rails_helper'
require 'pry'


describe DropsController do

  it "returns 200 if the drop exists" do
     get :show , {'id' => '187471639'}
     expect(@response.status).to eq(200)
  end
  it "creates the drop if the places already exists" do
    get :create, {
      'sc_url' => 'https://soundcloud.com/prince3eg/prince-3rdeyegirl-the-look-live-in-toronto-05-19-15',
      'drop' => {
        'place' => {
          'name' => Place.first.name
        }
      }
    }
    expect(@response.status).to eq(302)
    expect(Drop.last.place).to eq(Place.first)
  end
  it "returns 404 if the drop doesn't exist" do
     get :show , {'id' => '666'}
     expect(@response.status).to eq(404)
  end
end
