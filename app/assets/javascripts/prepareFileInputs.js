document.addEventListener('turbolinks:load', () => {
  const fileElement = document.querySelector('.file.has-name');
  if (!fileElement) {
    return;
  }

  const fileInput = fileElement.querySelector('.file-input');
  fileInput.addEventListener('change', () => {
    const label = fileElement.querySelector('.file-name');

    if (!fileInput.files.length) {
      label.innerHTML = 'No file chosen';
      return;
    }

    label.innerHTML = fileInput.files[0].name;
  });
});
