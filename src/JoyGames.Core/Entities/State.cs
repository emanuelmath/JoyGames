using JoyGames.Core.Enums;
using JoyGames.Core.Exceptions;

namespace JoyGames.Core.Entities
{
    public class State
    {
        public int Id { get; private set; }
        public string Name { get; private set; }

        public State(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre del estado no debe ir vacío.");
            Name = name;
        }
        public UserState TranslateUserState()
        {
            return Enum.IsDefined(typeof(UserState), Id)
           ? (UserState)Id
           : throw new DomainException("No es un estado válido de usuario.");
        }
        public ContactState TranslateContactState()
        {
            return Enum.IsDefined(typeof(ContactState), Id)
           ? (ContactState)Id
           : throw new DomainException("No es estado válido de contacto.");
        }
    }
}
