using JoyGames.Core.Enums;
using JoyGames.Core.Exceptions;

namespace JoyGames.Core.Entities
{
    public class Contact
    {
        public Guid Id { get; private set; }
        public string Message { get; private set; }
        public string Email { get; private set; }
        public ContactState State { get; private set; }
        public DateTime SentAt { get; private set; }


        public Contact(string message, string email, ContactState state, DateTime sentAt)
        {
            if (string.IsNullOrWhiteSpace(message)) throw new DomainException("El mensaje del contacto no debe ir vacío.");
            if (string.IsNullOrWhiteSpace(email)) throw new DomainException("El correo del contacto no debe ir vacío.");
            if (!Enum.IsDefined(state)) throw new DomainException("El estado debe ser válido.");

            Id = Guid.CreateVersion7();
            Message = message;
            Email = email;
            State = state;
            SentAt = sentAt;
        }

    }
}
