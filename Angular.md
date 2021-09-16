# Angular notes

A component can communicate with the template or another child component using <pm-start> or with service or using the <router-outlet>

  
## communicate with template
  
  binding and structural directives
  
  Interpolation -> {{}} \
  property binding -> < [] = '' > \
  event binding -> <button (click)='func()' > \
  two way bidning -> < [(ngModel)]='' > 
  
  
  Structural directives
  
  *ngIf=''
  *ngFor='let product for products'
  
  
## Notifying the component of user changes
  
  two way binding \
  getters and setters \
  valueChanges observable
  
  
### viewchild and viewchildren
  
  Provides a reference to native html element \
  Not available till ngAfterViewInit \
  doesnt work with server side rendering \
  viewchild is used to get a reference for a directive in the template \
  we can access the referred html element in ngAfterViewInit lifecycle hook \
  @viewChild('filterRef') filteredRef; \
  
  <input type='text' #filterRef ....>
  
  viewchildren returns QueryList
  
  Two types of angular forms
  1. Template driven and 2. Reactive
  
  viewchild doesnt work properly with ngif
  ngif evaluates to trues only when items are fetched. if the items are not fetched \
  then ngif will be empty and accessing the element will throw error
  
  
## Communication between parent and child
  
  Use Input to pass data from parent to child \
  In parent html \
  [child property name] = 'parent property name' \
  
  In child component \
  @Input() childvariableName;
  
  Waiting for changes on the input property in child component
  
  we can use gettter and setter
  
  @Input() \
  set hitcount(value: number) { \
    this._hitCount = value; \
  }
  
  Or use ngOnChanges from OnChanges lifecycle hook which takes a parameter of type SimpleChanges. \
  This works only with the input property and so works only in the child component.
  
  Or we can use template reference variable
