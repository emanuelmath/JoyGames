using JoyGames.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace JoyGames.Core.Interfaces.Repositories
{
    public interface IUserRepository
    {
        Task<Guid?> AddAsync(User user);
        Task<Guid?> UpdateAsync(User user);
    }
}
