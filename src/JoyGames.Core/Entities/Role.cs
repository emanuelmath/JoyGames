
using JoyGames.Core.Enums;
using JoyGames.Core.Exceptions;

namespace JoyGames.Core.Entities
{
    public class Role
    {
        public int Id { get; private set; }
        public string Name { get; private set; }

        public Role(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre del rol no debe ir vacío.");
            Name = name;
        }

        private Role() { }

        public UserRole TranslateRole()
        {
            return Enum.IsDefined(typeof(UserRole), Id)
           ? (UserRole)Id
           : throw new DomainException("No es un rol válido.");
        }
    }
}
