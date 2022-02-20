import { Controller } from '@hotwired/stimulus';

export default class NavBarController extends Controller {
  private static readonly activeBurgerClass = 'is-active';

  private static readonly activeMenuClass = 'is-active';

  static targets = ['burger', 'menu'];

  private burgerTarget!: HTMLElement;

  private menuTarget!: HTMLElement;

  public clickBurger(event: Event): void {
    event.preventDefault();
    this.burgerTarget.classList.toggle(NavBarController.activeBurgerClass);
    this.menuTarget.classList.toggle(NavBarController.activeMenuClass);
  }
}
