document.addEventListener('turbolinks:load', () => {
  const documentForm = document.querySelector('.document-form');
  if (!documentForm) {
    return;
  }

  document.body.addEventListener('drop', () => {
    waitUntilFileExists()
      .then(() => Rails.fire(documentForm, 'submit'));
  });

  documentForm.addEventListener('ajax:success', (event) => {
    const [,, { status }] = event.detail;

    console.log(status);
  });

  documentForm.addEventListener('ajax:error', (event) => {
    const [,, { status }] = event.detail;

    console.log(status);
  });
});


const waitUntilFileExists = () => {
  const fileInput = document.querySelector(".file-input");

  return new Promise(resolve => {
    setInterval(() => {
      if (!fileInput.files) {
        return;
      }

      resolve();
    }, 50);
  });
};
