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
  @viewChild('filterRef') filteredRef;
  
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
  [child property name] = 'parent property name'
  
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
  
  
  Child to parent communication is done throgh
  
  @Output event emitter

## Communicating through service
  
  property bag \
  basic state management \
  state management with notification
  
  getters are used to notify any component using angular change notification system. \
  Just bind the property name with the getter and whenever that value is changed, \
  the template is notified of it
  
  
  Notifications can be braodcast using
  
  EventEmitter \
  Subject \
  BehaviorSubject
  
  EventEmitter should be used with Output keyword. EventEmitter can be used only between parent and child \
  Hence it cant be used in a service. 
  
  A Subject is a special type of Observable that can multicast the events to multiple subscribers. \
  The source component can uupdate the data using the Subject's next method and then the Subject \
  will send out the notification to all subscribers.
  
  Postfixing $ to any variable indicates that its an observable and not a simple protperty 
  
  BehaviorSubject is different from Subject in two aspects 
  1. It needs an initial value 
  2. Provides the current value on a new subscription
  
  
  Communicating using router
  
  Angular routing provides three parameters 
  1. required : Use this when route requires a parameter Ex: /products/:id. Use either [routerLink] or this.route.navigate \
     the passed id can be fetched using this.route.snapshot.paramMap.get('id')
  2. Optional: We dont pass parameters in path definition but values can be passed in the code. \
      They can be specified as key and value pairs using {} 
  3. Query: They are passed as separate parameter using [queryParams] along with [routerLink] or {queryParams: {}} \
     Fetch the values using queryParamMap.get() 
     Data is retained across routes
  
  
### Summary
  
  #### Component to template
  
  Binding 
  Structural directive 
  viewchild/viewchildren with template reference and native element or with NgForm or NgModel 
  
  change notification 
  two way binding 
  getters and setters 
  viewchild and valuechanges observable 
  
  #### component to child component
  
  @Input 
  template reference variable 
  viewChild decorator
  
  Change notification
  
  getters and setters 
  onChanges lifecycle hook
  
  child to parent 
  @Output
  
  #### component to component
  
  simple properties 
  getters and setters 
  state management 
  subject 
  behaviorsubject 
  ngrx
  
  Routers
  
  Required 
  optional 
  query parameters
  

  
## Angular routing
  
  RouterOutlet decides where to display the template 
  RouterModule provides two methods 
  1. forRoot and forChild 
  No leading slashes 
  forRoot registers the router service and used once for the application   
  forChild doest not registers the router service and its used in feature modules  
  Order of the routes in the array matters. 
  More specific should always be before less specific  
  Redirects cannot be chained. they can be absolute or relative  
  Components template is displayed under <router-outlet>  

  Browser url styles 

  html5 (/welcome)  
  uses pushState without triggering server request 
  Are used by default  
  Requires url rewriting  
  


  Hash based (/#/welcome)  
  uses url fragments  
  must be set with {userHash: true} for RouterModule.forRoot()  
  doesnt require url rewriting  
  
  if we navigate using router.navigate then it retains the seconary route 
  but if we navigate using router.navigteByUrl then it wont retian the secondary route.
  
  the routes defined the feature modules are processed first and the the routes mentioned 
  in the app-routing.module.ts are processed later. So the wildcard route mentioned in the 
  main app module is always processed at the end 
  So the module names which are mentioned in `imports` array take precedence over the routes 
  explicitly mentioned in that file
  
  
  ### passing data between routes
  
  if only the parameter value in the url changes then the component is reused and not reinitialized 
  the ngOnInit function is not called again. In that case we need to watch for the parameter change 
  using an observable.
  All route details are in ActivatedRoute service 
  Route parameters can be read using snapshot or using obervable 
  
  optional parameters are ideal while passing complex data between routes. They should come after the required parameters. 
  we use query parameters which can work across routes and they can be retained. 
  they are not part of route configuration. we use the [queryParams] directive 
  By default, the router resets the query parameters. so when we navigate back, they are lost 
  we can retain them by using `queryParamsHandling="preserve"` or `merge`
  
  
  ### route resolvers
  
  prefetch the data before loading the data  
  Reuse the code  
  improves flow when an error occurs  
  Route has a `data` property. This can be used to pass any data. This cannot change. so it has be static data.  
  can be accessed using this.route.snapshot.data['key']  
  
  Prefetching data using route ersolver includes 3 steps.  
  1. Build a route resolver service.  
  2. Add resolve to the router configuration.  
  3. Read data from ActivatedRoute.  
  
  use this.route.snapshot.data[''] if the route never changes but if the route changes then use this.route.data.subscribe().  
  
  parent route can be accessed using this.route.parent.snapshot.data.  
  
  
  
  
  
  
  
