// lib/
// ├── main.dart
// ├── app.dart
// ├── core/
// │   ├── constants/
// │   │   ├── app_constants.dart
// │   │   ├── api_constants.dart
// │   │   └── storage_constants.dart
// │   ├── theme/
// │   │   ├── app_theme.dart
// │   │   ├── color_palette.dart
// │   │   └── theme_data.dart
// │   ├── routes/
// │   │   └── app_routes.dart
// │   ├── utils/
// │   │   ├── validators.dart
// │   │   ├── date_formatter.dart
// │   │   └── debouncer.dart
// │   ├── error/
// │   │   ├── failures.dart
// │   │   └── exceptions.dart
// │   └── network/
// │       └── network_info.dart
// ├── data/
// │   ├── datasources/
// │   │   ├── local/
// │   │   │   ├── auth_local_datasource.dart
// │   │   │   ├── todo_local_datasource.dart
// │   │   │   ├── settings_local_datasource.dart
// │   │   │   └── hive_service.dart
// │   │   └── remote/
// │   │       └── todo_remote_datasource.dart
// │   ├── models/
// │   │   ├── user_model.dart
// │   │   ├── todo_model.dart
// │   │   └── settings_model.dart
// │   └── repositories/
// │       ├── auth_repository_impl.dart
// │       ├── todo_repository_impl.dart
// │       └── settings_repository_impl.dart
// ├── domain/
// │   ├── entities/
// │   │   ├── user.dart
// │   │   ├── todo.dart
// │   │   └── app_settings.dart
// │   ├── repositories/
// │   │   ├── auth_repository.dart
// │   │   ├── todo_repository.dart
// │   │   └── settings_repository.dart
// │   └── usecases/
// │       ├── auth/
// │       │   ├── login_usecase.dart
// │       │   ├── register_usecase.dart
// │       │   ├── logout_usecase.dart
// │       │   └── check_auth_usecase.dart
// │       ├── todo/
// │       │   ├── get_todos_usecase.dart
// │       │   ├── toggle_favorite_usecase.dart
// │       │   └── search_todos_usecase.dart
// │       └── settings/
// │           ├── update_theme_usecase.dart
// │           └── clear_cache_usecase.dart
// └── presentation/
//     ├── bloc/
//     │   ├── auth/
//     │   │   ├── auth_bloc.dart
//     │   │   ├── auth_event.dart
//     │   │   └── auth_state.dart
//     │   ├── todo/
//     │   │   ├── todo_bloc.dart
//     │   │   ├── todo_event.dart
//     │   │   └── todo_state.dart
//     │   ├── profile/
//     │   │   ├── profile_bloc.dart
//     │   │   ├── profile_event.dart
//     │   │   └── profile_state.dart
//     │   ├── settings/
//     │   │   ├── settings_bloc.dart
//     │   │   ├── settings_event.dart
//     │   │   └── settings_state.dart
//     │   └── theme/
//     │       ├── theme_bloc.dart
//     │       ├── theme_event.dart
//     │       └── theme_state.dart
//     ├── pages/
//     │   ├── splash/
//     │   │   └── splash_screen.dart
//     │   ├── auth/
//     │   │   ├── login_screen.dart
//     │   │   └── registration_screen.dart
//     │   ├── home/
//     │   │   └── home_screen.dart
//     │   ├── profile/
//     │   │   └── profile_screen.dart
//     │   └── settings/
//     │       └── settings_screen.dart
//     └── widgets/
//         ├── common/
//         │   ├── custom_button.dart
//         │   ├── custom_text_field.dart
//         │   ├── loading_indicator.dart
//         │   ├── error_widget.dart
//         │   └── empty_state_widget.dart
//         ├── todo/ 
//         │   ├── todo_item_card.dart
//         │   └── todo_skeleton_loader.dart
//         └── profile/ 
//             ├── profile_avatar.dart
//             └── profile_completeness_indicator.dart