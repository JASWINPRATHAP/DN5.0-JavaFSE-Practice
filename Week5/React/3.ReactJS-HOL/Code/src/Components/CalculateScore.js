import React from 'react';
import '../Stylesheets/mystyle.css';

const CalculateScore = ({ Name, School, Total, goal }) => {
  const calculateResult = (total, goal) => {
    return (total / goal).toFixed(2);
  };
  return (
    <div className="format">
      <h1>Student Details</h1>
      <p>Name: {Name}</p>
      <p>School: {School}</p>
      <p>Total: {Total}</p>
      <p>Goal: {goal}</p>
      <p>Average: {calculateResult(Total, goal)}</p>
    </div>
  );
};

export default CalculateScore;
