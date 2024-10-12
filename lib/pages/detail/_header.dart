import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/pages/detail/modal/delete.dart';
import 'package:istiqomah/pages/detail/modal/edit.dart';

class Header extends StatelessWidget {
  const Header(this.habit, {Key? key, this.onChange,this.onRemove}) : super(key: key);

  final Habit habit;
  final Function(Habit)? onChange;
  final Function(Habit)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(),
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            habit.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(),
          color: Colors.white,
          icon: const Icon(Icons.delete),
          onPressed: () {
            modalDeleteHabit(context, habit.name).then((value) {
          if (value!) {
            Navigator.pop(context);

            onRemove!(habit);
          }
        });
          },
        ),
         IconButton(
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(),
          color: Colors.white,
          icon: const Icon(Icons.edit),
          onPressed: () {
            modalEditHabit(context, habit).then(
              (value) {
                if (value != null) {
                  onChange!(value);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
