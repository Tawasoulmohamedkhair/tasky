enum TaskActionItemsEnum {
  markasdone(name: 'Done || UnDone'),

  edit(name: 'Edit'),

  delete(name: 'Delete');

  final String name;

  const TaskActionItemsEnum({required this.name});
}
