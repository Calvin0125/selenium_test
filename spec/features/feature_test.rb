require 'rails_helper'

RSpec.describe 'root path', :js, type: :system do
  it 'has hello world' do
    visit '/'
    expect(page).to have_content('Hello World')
  end
end
