using System;
using System.Collections.Generic;
using System.Text;

namespace JoyGames.Core.Interfaces.Services
{
    public interface IFileStorageService : IDisposable
    {
        Task<string> SaveAsync();
    }
}
