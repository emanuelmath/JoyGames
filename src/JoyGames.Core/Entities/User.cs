using JoyGames.Core.Enums;
using JoyGames.Core.Exceptions;

namespace JoyGames.Core.Entities
{
    public class User
    {
        public Guid Id { get; private set; }
        public string Name { get; private set; }
        public string Email { get; private set; }
        public string UserName { get; private set; }
        public string Password { get; private set; }
        public UserRole UserRole { get; private set; }
        public UserState UserState { get; private set; }

        public User(string name, string email, string userName, string password, UserRole userRole)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre del usuario no puede ir vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new DomainException("El correo del usuario no puede ir vacío.");
            if (string.IsNullOrWhiteSpace(userName)) throw new DomainException("El nombre de usuario no puede ir vacío.");
            if (string.IsNullOrWhiteSpace(password)) throw new DomainException("La contraseña del usuario no puede ir vacía.");
            if (!Enum.IsDefined(userRole)) throw new DomainException("El rol del usuario debe ser válido.");

            Id = Guid.CreateVersion7();
            Name = name;
            Email = email;
            UserName = userName;
            UserRole = userRole;
            Password  = password;
            UserState = UserState.Active;
        }

        private User() { }

        public void UpdateUser(string name, string email, string userName, string password, UserRole userRole)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre del usuario no puede ir vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new DomainException("El correo del usuario no puede ir vacío.");
            if (string.IsNullOrWhiteSpace(userName)) throw new DomainException("El nombre de usuario no puede ir vacío.");
            if (string.IsNullOrWhiteSpace(password)) throw new DomainException("La contraseña del usuario no puede ir vacía.");
            if (!Enum.IsDefined(userRole)) throw new DomainException("El rol del usuario debe ser válido.");

            Name = name;
            Email = email;
            UserName = userName;
            UserRole = userRole;
            Password = password;
        }

        public void ChangeUserState(UserState state)
        {
            if (!Enum.IsDefined(state)) throw new DomainException("El estado del usuario debe ser uno válido.");
            UserState = state;
        }

    }
}
