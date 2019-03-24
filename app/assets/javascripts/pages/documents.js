const waitUntilFileExists = () => {
  const fileInput = document.querySelector('.file-input');

  return new Promise(resolve => {
    setInterval(() => {
      if (!fileInput.files) {
        return;
      }

      resolve();
    }, 50);
  });
};


document.addEventListener('turbolinks:load', () => {
  const documentForm = document.querySelector('.document-form');
  if (!documentForm) {
    return;
  }

  document.body.addEventListener('drop', () => {
    waitUntilFileExists()
      .then(() => Rails.fire(documentForm, 'submit'));
  });

  documentForm.addEventListener('ajax:success', event => {
    const [,, xhr] = event.detail;

    if (xhr.status === 201) {
      Turbolinks.visit(xhr.getResponseHeader('location'));
    }
  });

  documentForm.addEventListener('ajax:error', event => {
    const [,, { status }] = event.detail;

    // TODO Properly handle errors
    console.log(status);
  });
});
