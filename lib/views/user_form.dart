import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      _formData['id'] = user.id;
      _formData['nome'] = user.nome;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User? ??
        const User(
          nome: '',
          email: '',
          avatarUrl: '', id: '',
        );

    _loadFormData(user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                setState(() {
                  _isLoading = true;
                });

                try {
                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'] ?? '',
                      nome: _formData['nome'] ?? '',
                      email: _formData['email'] ?? '',
                      avatarUrl: _formData['avatarUrl'] ?? '',
                    ),
                  );
                } catch (e) {
                  // ignore: avoid_print
                  print('Failed to add user: $e');
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['nome'],
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nome inválido';
                        }

                        if (value.trim().length <= 3) {
                          return 'Nome muito pequeno. No minimo 3 letras.';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['nome'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['email'],
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      onSaved: (value) => _formData['email'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration:
                          const InputDecoration(labelText: 'Url do Avatar'),
                      onSaved: (value) => _formData['avatarUrl'] = value!,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}