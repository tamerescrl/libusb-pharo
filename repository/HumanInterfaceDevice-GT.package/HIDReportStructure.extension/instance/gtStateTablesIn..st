*HumanInterfaceDevice-GT
gtStateTablesIn: composite
	<gtInspectorPresentationOrder: 0>
	composite tree
		title: 'State tables';
		display: [ self itemStateTables ];
		children: [ :each | each gtChildren ]