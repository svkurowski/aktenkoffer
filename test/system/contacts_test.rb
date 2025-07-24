require 'application_system_test_case'

class ContactsTest < ApplicationSystemTestCase
  setup do
    @contact = contacts(:home)
    @unused_contact = contacts(:unused)

    login()
  end

  test 'visiting the index' do
    visit contacts_url

    assert_selector 'h1', text: 'Contacts'
  end

  test 'creating a contact' do
    @unused_contact.delete
    visit contacts_url
    click_on 'New Contact'

    fill_in 'Name', with: @unused_contact.name
    fill_in 'Address', with: @unused_contact.address
    click_on 'Submit'

    assert_text 'Contact was successfully created'
  end

  test 'updating a contact' do
    @unused_contact.delete
    visit contacts_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @unused_contact.name
    fill_in 'Address', with: @unused_contact.address
    click_on 'Submit'

    assert_text 'Contact was successfully updated'
  end

  test 'destroying a contact' do
    visit contacts_url

    click_link 'Delete', href: contact_path(@unused_contact), match: :one

    assert_text 'Contact was successfully deleted'
  end
end
