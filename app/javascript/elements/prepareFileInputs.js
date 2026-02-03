document.addEventListener('turbo:load', () => {
  const fileElement = document.querySelector('.file.has-name');
  if (!fileElement) {
    return;
  }

  const fileInput = fileElement.querySelector('.file-input');
  fileInput.addEventListener('change', () => {
    const label = fileElement.querySelector('.file-name');

    if (!fileInput.files.length) {
      label.textContent = 'No file chosen';
      return;
    }

    label.textContent = fileInput.files[0].name;
  });
});
