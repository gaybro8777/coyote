require 'spec_helper'

describe 'GET /api/v1/images/:id' do
  before(:each) do
    @image = create(:image)
  end
  it 'returns image record' do
    get "/api/v1/images/#{@image.id}", {}.to_json
    expect(response_json).to eq(image_json)
  end
end

describe 'GET /api/v1/images' do
  #optional params: page, canonical_id, status_ids, priority
  #Default is [2] for the public view.
  before(:each) do
    @images = []
    5.times do
      image = create(:image)
      @images << image
    end
  end
  it 'returns all image records to user' do
    @user = create(:user)
    get "/api/v1/images", {}.to_json
    expect(response_json).to eq(images_json(@images))
  end
end

#describe 'POST /api/v1/images' do
  #it 'returns error if validations fail' do
    #@user = create(:user)
    #post "/api/v1/images/", {"" => ""}.to_json, set_headers(@user.authentication_token)
    #expect(response_json).to eq({
      #'message' => 'Validation Failed',
      #'errors' => [
        #"",        
        #]
      #})
  #end
#end

#describe 'PATCH /api/v1/images/:id' do
  #before(:each) do
    #@image = create(:image)
  #end
  #it 'updates image attributes' do
    #@admin = create(:admin)
    #patch "/api/v1/images/#{@image.id}", image_json(page_urls: "").to_json, set_headers(@admin.authentication_token)
    #expect(response_json).to eq({
      #"id" => @image.id
      #})
  #end
#end

#describe 'DELETE /api/v1/images/:id' do
  #before(:each) do
    #@image = create(:image)
  #end
  #it 'destroys image if user is :admin' do
    #@admin = create(:admin)
    #delete "/api/v1/images/#{@image.id}", {}, set_headers(@admin.authentication_token)
    #expect(response_json).to eq({ "message" => "Image deleted."})
  #end
  ## it 'does not destroy image if user not authenticated' do
  ##   delete "/api/v1/images/#{@image.id}"
  ##   expect(response_json).to eq({ "message" => "Forbidden"})  
  ## end    
#end

def images_json(images)
  @images = []
  images.each do |image|
      @image = image
      @images << image_json
    end
  @images
end

def image_json(opts = {})
  hash = {
    id: opts[:id] || @image.id,
    canonical_id: "",
    created_at: opts[:created_at] || @image.created_at.strftime('%FT%T.%LZ'),
    updated_at: opts[:updated_at] || @image.updated_at.strftime('%FT%T.%LZ'),
    }.as_json
end
