// Entry point for the build script in your package.json

//= require turbolinks
//= require bulma-tagsinput/dist/js/bulma-tagsinput
//= require_tree .

import * as ActiveStorage from '@rails/activestorage';
import Turbolinks from 'turbolinks';
import Rails from '@rails/ujs';
import './components/ErrorNotification';
import './components/Notification';
import './components/WarningNotification';
import './elements/modals';
import './elements/navBar';
import './elements/prepareFileDropOverlay';
import './elements/prepareFileInputs';
import './elements/tagInputs';
import './pages/documents';

(() => {
  Rails.start();
  ActiveStorage.start();
  Turbolinks.start();
})();
