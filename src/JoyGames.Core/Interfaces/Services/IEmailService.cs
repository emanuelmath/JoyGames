using System;
using System.Collections.Generic;
using System.Text;

namespace JoyGames.Core.Interfaces.Services
{
    public interface IEmailService
    {
        Task SendAsync(string email, string message);
    }
}
