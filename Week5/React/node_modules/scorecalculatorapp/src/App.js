import React from 'react';
import CalculateScore from './Components/CalculateScore';

function App() {
  return (
    <div>
      <CalculateScore Name="John Doe" School="Greenwood High" Total={280} goal={4} />
    </div>
  );
}

export default App;
