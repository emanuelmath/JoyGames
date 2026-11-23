using JoyGames.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace JoyGames.Core.Interfaces.Repositories
{
    public interface ICategoryRepository
    {
        Task<int?> AddAsync(Category category);
    }
}
