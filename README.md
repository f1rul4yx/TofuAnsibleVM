# TofuAnsibleVM

Plantilla base para crear **escenarios reproducibles de máquinas virtuales**
usando **OpenTofu / Terraform + Ansible** sobre **QEMU/KVM**.

Este repositorio **no define un entorno concreto**, sino una **estructura de referencia**
a partir de la cual crear distintos escenarios (laboratorios, pruebas, formación, etc.).

---

## 🎯 Objetivo

- Servir como **base reutilizable** para desplegar VMs
- Separar claramente:
  - **Provisionamiento** (OpenTofu / Terraform)
  - **Configuración** (Ansible)
- Facilitar la creación de múltiples escenarios sin duplicar lógica

---

## 🧱 Estructura del repositorio

```
TofuAnsibleVM/
├── Ansible/        # Configuración de las VMs
├── OpenTofu/       # Provisionamiento principal (recomendado)
└── Terraform/      # Módulos reutilizables (opcional/legacy)
```

---

## 🔧 Ansible

```
Ansible/
├── ansible.cfg
├── hosts
├── group_vars/
│   └── all
├── roles/
│   ├── commons/    # Configuración común a todas las VMs
│   └── example/    # Rol de ejemplo (plantilla)
└── site.yaml
```

### Notas

- `group_vars/all` contiene **variables globales**
- `roles/example` es **solo un ejemplo**, no se aplica por defecto
- `roles/commons` define tareas base reutilizables
- `site.yaml` es el punto de entrada de Ansible

---

## 🚀 OpenTofu

```
OpenTofu/
├── main.tf
├── escenario.tf
├── cloud-init/
│   ├── base.yaml
│   └── server1/
│       ├── network-config.yaml
│       └── user-data.yaml
└── modules/
    └── vm/
```

### Notas

- Aquí se define **cada escenario**
- `escenario.tf` describe qué VMs se crean
- `cloud-init/` contiene configuraciones base por VM
- `modules/vm` encapsula la lógica reutilizable

---

## 🧪 Terraform

```
Terraform/
└── modules/
    ├── network/
    └── vm/
```

### Notas

- Contiene **módulos reutilizables**
- Puede usarse de forma independiente o como referencia
- Útil para separar lógica o mantener compatibilidad

---

## 🔁 Flujo de trabajo recomendado

1. Definir el escenario en `OpenTofu/`
2. Crear las VMs:
   ```bash
   tofu init
   tofu apply
   ```
3. Ajustar inventario o usar inventory dinámico
4. Ejecutar Ansible:
   ```bash
   ansible-playbook -i hosts site.yaml
   ```

---

## 🧩 Crear un nuevo escenario

1. Copiar o modificar `escenario.tf`
2. Añadir `cloud-init` específico si es necesario
3. Crear o reutilizar roles de Ansible
4. Ajustar variables en `group_vars/all`

---

## ⚠️ Avisos importantes

- Este repositorio es una **plantilla**
- No incluye valores seguros ni secretos
- No está pensado para producción sin adaptación
- Los roles `example` son puramente demostrativos

---

## 📌 Requisitos

- QEMU / KVM
- OpenTofu o Terraform
- Ansible
- Acceso SSH a las VMs

---

## 📖 Filosofía

- Infraestructura como código
- Separación clara de responsabilidades
- Reutilización sobre duplicación
- Escenarios declarativos y reproducibles

---

## 📜 Licencia

Uso libre para aprendizaje, pruebas y laboratorios.
