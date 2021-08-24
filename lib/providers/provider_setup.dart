import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/providers/locator.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => locator<ConversationProvider>(),
  ),
  ChangeNotifierProvider(
    create: (context) => locator<AuthProvider>(),
  ),
  ChangeNotifierProvider(
    create: (context) => locator<UserProvider>(),
  ),
];