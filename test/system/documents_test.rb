require 'application_system_test_case'

class DocumentsTest < ApplicationSystemTestCase
  setup do
    @document = documents(:one)
    @other_document = documents(:two)

    @home_contact = contacts(:home)
    @other_contact = contacts(:two)
    @unused_contact = contacts(:unused)

    # Ensure the home contact ID is set
    Aktenkoffer::Application.config.home_contact_id = @home_contact.id

    login()
  end

  test 'visiting the index' do
    visit documents_url
    assert_selector 'h1', text: 'Documents'
  end

  test 'creating a document' do
    visit documents_url
    click_on 'New Document'

    attach_file('Document', file_fixture('example.pdf'), make_visible: true)
    fill_in 'Received at', with: @document.received_at
    click_on 'Select Recipient'
    click_on @document.recipient.name
    click_on 'Select Sender'
    click_on @document.sender.name
    fill_in 'Received at', with: @document.received_at
    fill_in 'Sent at', with: @document.sent_at
    fill_in 'Title', with: @document.title
    click_on 'Submit'

    assert_text 'Document was successfully created'
  end

  test 'creating one document using drag and drop' do
    visit documents_url

    target = page.find('body')
    target.drop(file_fixture('example.pdf'))

    # Currently there is no notification for creation success
    assert_link 'Edit'
  end

  test 'updating a document' do
    visit documents_url
    click_on @other_document.title
    click_on 'Edit'

    fill_in 'Received at', with: @document.received_at
    click_on 'Select Sender'
    click_on @document.recipient.name
    click_on 'Select Recipient'
    click_on @unused_contact.name
    fill_in 'Sent at', with: @document.sent_at
    fill_in 'Title', with: @document.title
    click_on 'Submit'

    assert_text 'Document was successfully updated'
  end

  test 'destroying a document' do
    visit documents_url
    click_on 'Show', match: :first

    click_on 'Delete', match: :one

    assert_text 'Document was successfully deleted'
  end

  test "auto-selects home contact as recipient when sender is set to another contact" do
    visit new_document_path

    # Open sender dropdown and select non-home contact
    within("#document_sender_select") do
      find(".dropdown-trigger button").click
      find("a[data-select-contact-target='option'][data-value='#{@other_contact.id}']").click
    end

    # Check that recipient was auto-selected to home contact
    recipient_field = find("#document_recipient_id", visible: false)
    assert_equal @home_contact.id.to_s, recipient_field.value
  end

  test "auto-selects home contact as sender when recipient is set to another contact" do
    visit new_document_path

    # Open recipient dropdown and select non-home contact
    within("#document_recipient_select") do
      find(".dropdown-trigger button").click
      find("a[data-select-contact-target='option'][data-value='#{@other_contact.id}']").click
    end

    # Check that sender was auto-selected to home contact
    sender_field = find("#document_sender_id", visible: false)
    assert_equal @home_contact.id.to_s, sender_field.value
  end

  test "does not change recipient when it already has a value" do
    # Ensure recipient already has a value
    @document.update(recipient: @other_contact)

    visit edit_document_path(@document)

    # Open sender dropdown and select non-home contact
    within("#document_sender_select") do
      find(".dropdown-trigger button").click
      find("a[data-select-contact-target='option'][data-value='#{@other_contact.id}']").click
    end

    # Check that recipient was not changed
    recipient_field = find("#document_recipient_id", visible: false)
    assert_equal @other_contact.id.to_s, recipient_field.value
  end

  test "does not change sender when it already has a value" do
    # Ensure sender already has a value
    @document.update(sender: @other_contact)

    visit edit_document_path(@document)

    # Open recipient dropdown and select non-home contact
    within("#document_recipient_select") do
      find(".dropdown-trigger button").click
      find("a[data-select-contact-target='option'][data-value='#{@other_contact.id}']").click
    end

    # Check that sender was not changed
    sender_field = find("#document_sender_id", visible: false)
    assert_equal @other_contact.id.to_s, sender_field.value
  end
end
