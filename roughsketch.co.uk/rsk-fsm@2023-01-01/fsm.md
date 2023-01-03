# Finite State Machine behaviour

## Events and Actions

This FSM schema models system behaviour as actions. Actions are executed (performed) as a result of the FSM receiving and handling an event. It is assumed that only one event is handled at any time and that the FSM runs to completion before handling any new event. Each named action conceptually maps to a callback function and the action is executed by invoking that callback function. When a list of actions is specified, actions are executed in the listed order.

## Transition types

When the FSM transitions to a next state on handling an event, including when it leaves the current state and immediately re-enters it, actions may be executed on leaving a state (exit actions), on transition (transition actions) and on entering a state (enter actions). Alternatively, the FSM may remain in the current state when handling an event, in which case only transition actions will be executed. Here these two types of transition are respectively termed "external transition" (always leaves the current state) and "internal transition" (never leaves the current state).

## States

Any state of the FSM may have substates, with substates being nested to any degree, forming a state hierarchy. For the purposes of specification, all root states of the FSM (states which are not nested in another state) are considered to be contained under a single logical root. (The term "logical root" is used and not "logical root state" as this is not a state of the system: a transition to it or from it can never be specified.) Therefore the logical root is the root node of a tree whose nodes are the logical root and all the states of the FSM.

## Internal transitions

For an internal transition, the exact sequence of actions to execute is determined solely by the transition: it is the transition actions.

## External transitions

For an external transition, the exact sequence of actions to execute is determined by the current state of the FSM, the transition actions and the transition next state. Firstly, the common parent node of the current and next states is determined from the tree: it is the most deeply nested node which nests both states. The common parent may be any state from the current state up to and including the logical root: it is the current state when the current state nests the next state; it is the logical root when the current state and next state are under (directly under or nested under) different root states. Exit actions are executed for each state from the current state up to, but not including, the common parent, in reverse order of state nesting. (Exit actions are executed for the most nested state first, least nested state last.) Transition actions are executed after executing all exit actions and before executing any entry actions. Entry actions are executed for each state from, but not including, the common parent, down to the next state in forward order of state nesting. (Entry actions are executed for the least nested state first, most nested state last.)

## Next states

When a transition does not specify a next state value, then the transition is an internal transition.

Otherwise, the transition is an external transition. The next state for an external transition can be specified in several ways:

* A state pointer can be used to specify any state in the state hierarchy:
  * an absolute state pointer addresses states relative to the logical root;
  * a relative state pointer addresses states relative to the state where the transition is specified.
* A state name is used to specify a sibling state of the state where the transition is specified.
* The null value specifies completion of behaviour for the set of sibling states where the transition is specified.

### Completion of behaviour

Using the null value to specify the next state indicates that the FSM must transition out of the set of sibling states where the transition is specified.

When the set of sibling states is the set of root states of the FSM, then the FSM terminates. After this "final transition" the FSM will not be in any state.

When the set of sibling states is a nested set of states, then the next state is the parent state of the state where the transition is specified. This is a final transition for this set of states.

For all final transitions, exit and transition actions are executed as the FSM transitions out of its current state: entry actions are never executed as no state is entered.

## Initial states

The initial state of the FSM is specified as the name of a root state. When the FSM is instantiated it transitions into this state. Before this "initial transition" the FSM is not in any state.

A state with nested states may also specify an initial state. When such a state is the next state of a transition (including that of an initial transition) then, upon entering the state, an initial transition is made using its specified initial state as the next state. All such initial transitions are taken until a state with no specified initial state is entered.

For all initial transitions, entry actions are executed as the FSM transitions into the initial state.

Note that initial transitions are only taken for a state when it is the specified next state: they are not taken when the next state of a transition directly specifies one of its nested states. Also note that the initial transition is not taken when the state is the parent state for a final transition as the state is not being re-entered.

## Transition selection

Upon receiving an event, the transition to take is determined by the event, the current state and, for conditional transitions, state variables.

Firstly, a list of candidate transitions is logically constructed. Transitions for this event are included for all states from the current state up to, but not including, the logical root, in reverse order of state nesting. (Transitions for the current state appear first, nesting root state last.) Transitions for a state are included in list order of specification. (In this manner a state's transitions are inherited by its nested states.)

Candidate transitions are then tested in turn:
* If a transition is unconditional (it does not specify a condition), then the transition is taken; no further candidates are tested.
* If a transition is conditional, then if its condition tests true, then the transition is taken; no further candidates are tested.
* If the list of candidate transitions is empty, or no transition is taken, then the event is discarded.

Each condition name conceptually maps to a boolean callback function and a condition is tested by invoking the callback function. A positive condition tests true when the callback function returns a truthy value; a negative condition tests true when the callback function returns a falsy value.
