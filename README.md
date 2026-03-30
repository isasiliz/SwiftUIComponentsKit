# SwiftUIComponentsKit

## Overview
`SwiftUIComponentsKit` es un Swift Package con componentes reutilizables en SwiftUI para flujos de UI comunes.

Objetivo actual del paquete:
- encapsular componentes listos para uso en app (`PrimaryButton`, `CustomTextField`, `CustomSegmentedControl`, `CustomRadioButton`),
- mantener APIs públicas simples,
- validar la lógica base con tests unitarios.

## Components included

### `PrimaryButton`
Botón principal con variantes visuales (`primary`, `secondary`, `danger`, `neutral`) y estados `isLoading` / `isDisabled`.

### `CustomTextField`
Campo de texto con título, validaciones mínimas (`minLength`, `maxLength`), opción de limpiar texto y callback de acciones (`CustomTextFieldAction`).

### `CustomSegmentedControl`
Selector segmentado de opciones string con estado seleccionado por `Binding` y callback opcional de selección.

### `CustomRadioButton`
Grupo de radio buttons para opciones string con estado seleccionado por `Binding` y callback opcional.

## Installation / usage

### Swift Package Manager
En Xcode: **File > Add Package Dependencies...** y agregar este repositorio.

Luego importar el módulo:

```swift
import SwiftUIComponentsKit
```

### Basic usage snippets

#### `PrimaryButton`
```swift
PrimaryButton(
    title: "Continuar",
    variant: .primary,
    isLoading: false,
    isDisabled: false
) {
    // action
}
```

#### `CustomTextField`
```swift
@State private var email = ""

CustomTextField(
    title: "Email",
    placeholder: "name@example.com",
    text: $email,
    minLength: 5,
    maxLength: 60,
    keyboardType: .emailAddress,
    textInputAutocapitalization: .never,
    autocorrectionDisabled: true,
    showsClearButton: true
)
```

#### `CustomSegmentedControl`
```swift
@State private var size = "Medium"

CustomSegmentedControl(
    title: "Size",
    options: ["Small", "Medium", "Large"],
    selectedOption: $size
)
```

#### `CustomRadioButton`
```swift
@State private var presentation = "Cone"

CustomRadioButton(
    title: "Presentation",
    options: ["Cone", "Cup", "1/4 Kg"],
    selectedOption: $presentation
)
```

## Testing
El paquete ya incluye tests unitarios básicos para lógica de componentes y estilos.

Cobertura actual (alcance):
- reglas de habilitación/deshabilitación en `PrimaryButton`,
- reglas de longitud/validación y clear button en `CustomTextField`,
- actualización de selección y callback en `CustomSegmentedControl` y `CustomRadioButton`,
- mapeo visual por variante en `ButtonVariant`.

No cubre snapshot/UI testing ni pruebas de integración de pantallas completas.

## Conventions
Guía liviana basada en cómo está implementado hoy el package.

### Access control
- Exponer como `public` solo lo necesario para consumir el componente.
- Preferir `public init(...)` claro y mantener detalles internos sin exponer.
- Usar helpers internos/estáticos para lógica testeable cuando aplique.

### Separation of concerns
- Mantener componentes reutilizables en `Sources/SwiftUIComponentsKit`.
- Mantener tests unitarios en `Tests/SwiftUIComponentsKitTests`.

### Component API design
- API corta y directa.
- Defaults razonables para reducir configuración.
- Evitar superficie pública innecesaria.

### Component states
- Modelar estados explícitos cuando impactan UX (`isLoading`, `isDisabled`, selección, validación).
- Resolver reglas de estado en funciones predecibles y testeables.

### Styling
- Reutilizar colores/tokens existentes del kit (`GelatoColors`, `ButtonVariant`).
- Evitar hardcodear criterios visuales repetidos en múltiples componentes.

## Component template guidelines (base)
Esta plantilla es solo guía para mantener consistencia (sin crear frameworks nuevos).

1. **Archivo y estructura**
   - Crear el componente como `public struct ...: View` en `Sources/SwiftUIComponentsKit/<Feature>/`.
   - Mantener `body` simple y mover reglas a helpers estáticos cuando convenga.

2. **API pública mínima**
   - Exponer solo parámetros que el consumidor realmente necesite.
   - Definir defaults útiles en el `public init`.
   - Dejar propiedades internas sin `public` salvo necesidad real.

3. **Supporting types**
   - Crear tipos de apoyo (enum/config/action) solo si mejoran claridad o evitan duplicación.
   - Ubicarlos en el mismo feature folder del componente.

4. **Estados**
   - Declarar estados esperables (loading, disabled, selected, validation).
   - Hacer explícita la prioridad de estado cuando haya combinaciones.

5. **Ejemplos mínimos**
   - Incluir en README un ejemplo de uso real con `@State`/`@Binding`.
   - Mostrar al menos estado base + un estado relevante (por ejemplo disabled o error).

6. **Tests mínimos**
   - Agregar tests unitarios para la lógica de estado y callbacks.
   - Priorizar funciones puras/helpers para facilitar cobertura rápida y estable.
