
## Overview
This project is built on an **Action-based architecture**, where every operation in the application—ranging from user interactions to data fetching—is represented as an **Action**. The architecture is structured around **Reducers**, which manage and redirect these Actions as needed.

## Architecture

### State
- **Reducer** works with **State**, which maintains the observable state of each view.
- The **State** triggers Actions whenever changes occur, ensuring a reactive and dynamic UI.

### Actions
- Every event in the application is an **Action**.
- Actions are processed by **Reducers**, which determine how they should be handled.

### Reducers
- Each **View** works with a **Reducer**.
- Reducers handle incoming Actions and decide whether to process them internally or redirect them to another part of the application.

### Navigation
Navigation is designed as a structured system that manages screen presentations and data flow between views. It is divided into two core types:

#### **Navigation Types**
1. **NavigationItem**
   - Represents a **final screen** that does not push or present other views.
   - Responsible for handling Actions from child or parent views and passing them to its Reducer.

2. **NavigationState**
   - Handles **navigation actions** such as push, pop, present, and dismiss.
   - Manages **screen transitions** and coordinates navigation logic.
   - Can act as a **NavigationItem** itself when necessary.

#### **Navigation Flow**
- **NavigationState** is responsible for determining navigation actions and routing them to the appropriate child or parent.
- **NavigationItem** forwards specific Actions to its **parent Reducer**, ensuring a structured and predictable flow.
- Both **NavigationState** and **NavigationItem** are final implemented types and must be added to **Reducers** to properly handle navigation.

## Protocols & Generics
- The architecture is built on **protocols** and **generics** to ensure flexibility and reusability.
- Each **NavigationState** interacts with a screen defined by an **AppScreen protocol**, determined by the Reducer.
- Screens have their own **Actions**, and if they need to communicate with a parent view, they can define a **parent Reducer Action** as an associated type.
- **NavigationState** automatically manages passing these Actions appropriately.

## Summary
This architecture ensures a **scalable, maintainable, and predictable** navigation and state management system using **Reducers, Actions, and a structured Navigation flow**. By leveraging **protocols and generics**, it provides flexibility while maintaining strong type safety.
