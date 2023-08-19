## Todo Mobile App

Description:
A Todo app built using the `Flutter TDD Clean Architecture` and `Test Driven Development`.
- It connects UI components with the Bloc pattern for state management.
- It applies Clean Architecture principles to maintain separation of concerns and modularity.
- It implements the required UI components and interaction to showcase the task management functionalities.

It integrates and consume the Bloc pattern for various task management functionalities. This will involve:
- creating task
- updating task
- retrieving all tasks
- getting task details



Page Designs and Logic Flow:

- Create Task Page:
    - A designed screen that allows users to input task details and create a new task.
    - Consumes the appropriate bloc method to handle the task creation process.
    - Displays feedback to the user based on the success or failure of the creation process.
- Retrieve All Tasks Page:
    - Designed screen that displays a list of all tasks.
    - Consumes the bloc method responsible for retrieving all tasks.
    - Implements UI components to display the list of tasks, including task titles and statuses.
- Task Detail Page:
    - Designed screen that shows detailed information about a selected task.
    - Consumes the bloc method to fetch task details based on the selected task.
    - Displays the task title, description, due date, and status on the detail page.
- Navigation and Routing:
    - A proper set-up navigation between the task-related pages (create task, all tasks, task detail).
    - Appropriated routing mechanisms to ensure a smooth user experience.
- Testing:
    - Written unit tests to ensure that UI components are correctly connected to the Bloc and reflect the expected behavior.
    - Tests to verify that the UI responds appropriately to different states emitted by the Bloc.
- Code Cleanup and Refactoring:
    - Clean Architecture principles to organize your code into presentation, domain, and data layers.
    - A code which is readable, maintainable, and follows best practices.


### Folder Structure
```
lib
│   bloc_observer.dart
│   injection_container.dart     
│   main.dart
│
├───core
│   ├───constants
│   │       constants.dart       
│   │
│   ├───error
│   │       exceptions.dart      
│   │       failures.dart        
│   │
│   ├───network
│   │       network_info.dart    
│   │
│   ├───usecases
│   │       usecase.dart
│   │
│   └───util
│           input_convertor.dart 
│
└───features
    └───todo
        ├───data
        │   ├───datasources      
        │   │       task_local_datasource.dart
        │   │       task_remote_datasource.dart
        │   │
        │   ├───models
        │   │       task_mapper.dart
        │   │       task_model.dart
        │   │
        │   └───repositories
        │           task_repository_impl.dart
        │
        ├───domain
        │   ├───entities
        │   │       task.dart
        │   │       
        │   ├───repositories
        │   │       task_repository.dart
        │   │
        │   └───usecases
        │           create_task.dart
        │           edit_task.dart
        │           get_task.dart
        │           remove_task.dart
        │           usecases.dart
        │           view_all_tasks.dart
        │
        └───presentation
            ├───bloc
            │       task_bloc.dart
            │       task_event.dart
            │       task_state.dart
            │
            ├───screens
            │       add_task_screen.dart
            │       onboarding_screen.dart
            │       task_detail_screen.dart
            │       task_list_screen.dart
            │
            └───widgets
                    custom_date_field.dart
                    custom_text_field.dart
                    loading_widget.dart
                    show_status.dart
                    task_feature_container.dart
                    todo_list.dart

```






### Screenshots
<div style="display: flex; flex-direction:row; gap: 5px">
  <img width='180'    
    src="assets/images/onboarding.jpg"
  />
  <img width='180'
    src="assets/images/first-task-list.jpg"
  />
  <img width='180'
    src="assets/images/create-task.jpg"
  />
  <img width='180'
      src="assets/images/date-picker.jpg"
    />
  <img width='180'
      src="assets/images/created-task.jpg"
    />
  <img width='180'
  src="assets/images/task-detail.jpg"
  />
  <img width='180'
      src="assets/images/update-task.jpg"
    />
  <img width='180'
      src="assets/images/updated-task.jpg"
    />
  <img width='180'
      src="assets/images/delete-task.jpg"
    />
  <img width='180'
      src="assets/images/deleted-task.jpg"
    />
</div>